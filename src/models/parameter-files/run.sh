inputfilename=$2
modelname=$1
cd ../../../run/
mkdir $inputfilename
cd $inputfilename
mkdir output error log

job_file="myjob.submit"
cat > "$job_file" <<EOF
executable              = /usr/lib64/openmpi/bin/mpirun
arguments               = -n 16 ../../build/${modelname} input=../../src/models/parameter-files/${inputfilename}.in
getenv                  = true
output                  = output/results.output.\$(ClusterId).\$(Process)
error                   = error/results.error.\$(ClusterId).\$(Process)
log                     = log/results.log.\$(ClusterId)
request_cpus            = 16
request_memory          = 8 GB
notification            = never
queue 1
EOF

condor_submit myjob.submit
cd ../../src/models/parameter-files
