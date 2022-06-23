function fail() {
  echo "ERROR: $@"
  exit 1
}

# Run command inside docker at directory $(pwd)/bench
INPUT_FILE=$1
NUMBER_OF_NODES=$2
HOSTS=$3
MAX_LAMMPS_STEPS=$4
STDOUT_FILE=proxy_full_out
FINAL_TIME_FILE=proxy_time.txt
docker run --rm --user=$(id -u):$(id -g) -v $(pwd):$(pwd) -w $(pwd)/bench -e MAX_LAMMPS_STEPS=$MAX_LAMMPS_STEPS ubuntu:mpi-dev \
	-np $NUMBER_OF_NODES -host $HOSTS ../build/lmp -in $INPUT_FILE 1> $STDOUT_FILE 2> in.spce.results.stderr || \
	fail "Error when executing LAMMPS"
	
cat $STDOUT_FILE | grep "Loop time of" | cut -d " " -f 4 > $FINAL_TIME_FILE