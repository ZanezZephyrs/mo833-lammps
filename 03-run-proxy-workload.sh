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
FINAL_TIME_FILE=time.txt

export MAX_LAMMPS_STEPS=$MAX_LAMMPS_STEPS

mpirun -np $NUMBER_OF_NODES --hostfile $HOSTS -X MAX_LAMMPS_STEPS=$MAX_LAMMPS_STEPS  ../build/lmp -in $INPUT_FILE 1> ../$STDOUT_FILE 2> results.stderr || \
	fail "Error when executing LAMMPS"
	
cat ../$STDOUT_FILE | grep "Loop time of" | cut -d " " -f 4 > ../$FINAL_TIME_FILE