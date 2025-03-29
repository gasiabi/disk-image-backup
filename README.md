# disk-image-backup

This Bash script creates a forensic image of a block device (e.g., `/dev/loop3`) and saves it as a timestamped `.img` file. It also verifies data integrity by comparing SHA-256 checksums of the original device and the resulting image.

- Copies raw block device using `dd`
- Stores image with timestamp-based filename
- Calculates and compares SHA-256 checksums
- Outputs verification results to a `.txt` report
- All files are saved in the `./results/` directory
