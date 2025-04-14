#include <iostream>
#include <cstdio>
#include <string>
#include <thread>
#include <vector>
#include <chrono>
#include <pqxx/pqxx>

// Parámetros
const int users = 30;
const int seat_id = 4;
const int event_id = 1;
const std::string isolation = "READ COMMITTED";
const std::string conninfo = "host=db port=5432 dbname=sim user=postgres password=postgres";

// Abre una conexión a la base de datos
// Verifica si ya existe una reservación previa
// Si no, realiza la reservación
void make_reservation(int id, int user_id) {
	try {
		pqxx::connection cx(conninfo);

		{
			pqxx::nontransaction iso_config(cx);
			iso_config.exec0("SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL " + isolation);
		}

		std::cout << "[Thread " << id << "] Attempting to make a reservation.\n";

		pqxx::work tx(cx);
		pqxx::result r;

		r = tx.exec_params(
            "SELECT 1 FROM reservations WHERE event_id = $1 AND seat_id = $2",
            event_id, seat_id
        );

		if (!r.empty()) {
            std::cout << "[Thread " << id << "] Seat is already taken.\n";
            return;
        }

        tx.exec_params(
            "INSERT INTO reservations (seat_id, event_id, user_id) VALUES ($1, $2, $3)",
            seat_id, event_id, user_id
        );

		tx.commit();

		std::cout << "[Thread " << id << "] Reservation successful.\n";

	} catch (const pqxx::serialization_failure &e) {
        std::cout << "[Thread " << id << "] Serialization failure" << std::endl;
    }
}

int main() {
	std::vector<std::thread> threads;
	int user_id = 1;

	// Ejecución de la simulación
	auto start_time = std::chrono::high_resolution_clock::now();

	for (int i = 0; i < users; i++) {
		threads.push_back(std::thread(make_reservation, i, user_id));
		user_id++;
	}

	for (auto &th: threads) {
		th.join();
	}

	auto end_time = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double, std::milli> ms = end_time - start_time;

	std::cout << "Time: " << ms.count() << std::endl;

	return 0;
}
