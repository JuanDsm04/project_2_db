#include <iostream>
#include <string>
#include <thread>
#include <vector>
#include <pqxx/pqxx>

int users = 5;
std::string conninfo = "host=db port=5432 dbname=sim user=postgres password=postgres";

void make_reservation(int id) {
	pqxx::connection cx(conninfo);

	std::cout << "Attempting to make reservation from thread " << id << std::endl;
}

int main() {
	std::vector<std::thread> threads;

	for (int i = 0; i < users; i++) {
		threads.push_back(std::thread(make_reservation, i));
	}

	for (auto &th: threads) {
		th.join();
	}

	return 0;
}
