function fail() {
  echo "ERROR: $@"
  exit 1
}

#in.spce
INPUT_FILE=$1
#"localhost,localhost"
NUMBER_OF_NODES=$2
HOSTS=$3
STDOUT_FILE=full_run_full_out
FINAL_TIME_FILE=time.txt
# Run command inside docker at directory $(pwd)/bench
mpirun -np $NUMBER_OF_NODES --hostfile $HOSTS  ../build/lmp -in $INPUT_FILE 1> ../$STDOUT_FILE 2> results.stderr || \
	fail "Error when executing LAMMPS"
	
cat ../$STDOUT_FILE | grep "Total time" | cut -d "," -f 2 > ../$FINAL_TIME_FILE