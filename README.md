This includes all of the MATLAB and shell scripts required for each stage of a longitudinal VBM for a sample of 1,217 adolescents across 3 timepoints.

1. For the serial longitudinal registration, I submitted the serial_reg_csf.m script and the submit_serial.sh
2. For the segmentation, I submitted segment.m and segment_avg.sh
3. For geodesic shooting (create new templates), I submitted shoot.m and submit_shoot.sh
4. For the final stage of preprocessing, I normalised and smoothed at the same time - using normalise.m and submit_norm.sh

After this, the actual analysis starts so I need to:
1. Generate intracrancial volumes for each individual to control for within the model (taking this information from the segmentation step in the preprocessing pipeline)
2. Run the factorial design (we're using a Multiple Regression approach for this analysis)

_Analysis scripts are incoming - yet to be done_
