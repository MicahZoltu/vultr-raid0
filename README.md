1. Replace the SSH public key in `preseed-raid0.cfg` with your public key.
1. Host `preseed-raid0.cfg` somewhere that is publicly accessible over `http` (not `https`).
1. Update the link to `preseed-raid0.cfg` in `startup.sh`.
1. Public `startup.sh` as a Vultr boot script (not PXE).
1. Create a new bare metal server (Ubuntu) and tell it to use the uploaded boot script.
