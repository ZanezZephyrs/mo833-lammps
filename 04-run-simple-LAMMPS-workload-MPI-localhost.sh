function fail() {
  echo "ERROR: $@"
  exit 1
}

#in.spce
INPUT_FILE=$1
#"localhost,localhost"
NUMBER_OF_NODES=$2
HOSTS=$3
STDOUT_FILE=proxy_full_out
FINAL_TIME_FILE=full_time.txt
# Run command inside docker at directory $(pwd)/bench
docker run --rm --user=$(id -u):$(id -g) -v $(pwd):$(pwd) -w $(pwd)/bench ubuntu:mpi-dev \
	mpirun -np $NUMBER_OF_NODES --hostfile $HOSTS ../build/lmp -in $INPUT_FILE 1> $STDOUT_FILE 2> in.spce.results.N.2.stderr || \
	fail "Error when executing LAMMPS"
	
cat $STDOUT_FILE | grep "Loop time of" | cut -d " " -f 4 > $FINAL_TIME_FILE