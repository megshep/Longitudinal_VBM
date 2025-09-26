#!/bin/bash

# Directory containing your SLURM output files
LOGDIR=/mnt/iusers01/nm01/j90161ms/logs

# Count total submitted jobs
TOTAL=$(ls $LOGDIR/serial_reg_6855517_*.out 2>/dev/null | wc -l)

# Count completed jobs (look for the specific "Done" message)
DONE_COUNT=$(grep -l "Done" $LOGDIR/serial_reg_6855517_*.out 2>/dev/null | wc -l)

# Print summary
echo "Total jobs submitted: $TOTAL"
echo "Jobs completed: $DONE_COUNT"
