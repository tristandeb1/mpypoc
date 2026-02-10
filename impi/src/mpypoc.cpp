#include <mpi.h>
#include <iostream>

int main(int argc, char **argv) {
    MPI_Init(&argc, &argv);

    int world_rank = 0;
    int world_size = 1;
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);

    double local_value = static_cast<double>(world_rank) + 1.0;
    double global_sum = 0.0;

    MPI_Reduce(&local_value,
               &global_sum,
               1,
               MPI_DOUBLE,
               MPI_SUM,
               0,
               MPI_COMM_WORLD);

    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int name_len = 0;
    MPI_Get_processor_name(processor_name, &name_len);

    std::cout << "Rank " << world_rank << " / " << world_size
              << " on " << processor_name
              << " computed local value " << local_value << std::endl;
    
    if (world_rank == 0) {
        std::cout << "Root rank reports global sum = "
                  << global_sum << std::endl;
    }

    MPI_Finalize();
    return 0;
}
