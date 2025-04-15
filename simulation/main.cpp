#include <iostream>
#include <cstdio>
#include <string>
#include <thread>
#include <vector>
#include <chrono>
#include <random>
#include <atomic>
#include <pqxx/pqxx>

// Parámetros
const int users = 30;
const int event_id = 1;
const std::string isolation = "READ COMMITTED";
const std::string conninfo = "host=db port=5432 dbname=sim user=postgres password=postgres";

// Contadores
std::atomic<int> successful_reservations(0);
std::atomic<int> failed_reservations(0);

// Abre una conexión a la base de datos
// Verifica si ya existe una reservación previa
// Si no, realiza la reservación
void make_reservation(int id, int user_id, int seat_id) {
	while (true) {
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
				std::cout << "[Thread " << id << "] Reservation failed.\n";
				failed_reservations++;
				return;
			}

			tx.exec_params(
				"INSERT INTO reservations (seat_id, event_id, user_id) VALUES ($1, $2, $3)",
				seat_id, event_id, user_id
			);

			tx.commit();

			std::cout << "[Thread " << id << "] Reservation successful.\n";
			successful_reservations++;
			return;

		} catch (const pqxx::serialization_failure &e) {
			std::cout << "[Thread " << id << "] Serialization failure, will retry reservation." << std::endl;

		} catch (const std::exception &e) {
			std::cout << "[Thread " << id << "] Reservation failed." << std::endl;
			failed_reservations++;
			return;
		}
	}
}

// Genera un vector del tamaño especificado con números aleatorios
// Representan el número del asiento que un usuario desea reservar
std::vector<int> generate_seats(int size) {
	std::vector<int> seats(size);

	std::random_device rd;
	std::mt19937 engine{rd()};
	std::uniform_int_distribution<int> dist(1, size);

	for (int i = 0; i < size; i++) {
		seats[i] = dist(engine);
	}

	return seats;
}

int main() {
	std::vector<std::thread> threads;
	std::vector<int> seats(users);
	int user_id = 1;

	// Generación de los asientos a reservar
	seats = generate_seats(users);

	// Ejecución de la simulación
	auto start_time = std::chrono::high_resolution_clock::now();

	for (int i = 0; i < users; i++) {
		threads.push_back(std::thread(make_reservation, i, user_id, seats[i]));
		user_id++;
	}

	for (auto &th: threads) {
		th.join();
	}

	auto end_time = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double, std::milli> ms = end_time - start_time;

	std::cout << "\nSuccessful reservations: " << successful_reservations << "\n";
	std::cout << "Failed reservations: " << failed_reservations << "\n";
	std::cout << "Time: " << ms.count() << "ms" << std::endl;

	return 0;
}
