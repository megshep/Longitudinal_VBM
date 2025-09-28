#!/bin/bash

# Directory containing your output and error files from each of the job arrays submitted (logs)
LOGDIR=/mnt/iusers01/nm01/j90161ms/logs

# Counts the total jobs that were submitted
TOTAL=$(ls $LOGDIR/serial_reg_6855517_*.out 2>/dev/null | wc -l)

# Counts the total completed jobs (look for the specific "Done" message that is produced in a successful .out file)
DONE_COUNT=$(grep -l "Done" $LOGDIR/serial_reg_6855517_*.out 2>/dev/null | wc -l)

# Print summary to tell us how many were run and how many of those were successful
echo "Total jobs submitted: $TOTAL"
echo "Jobs completed: $DONE_COUNT"
