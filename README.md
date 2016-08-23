# Sample NAT-box, as a show case for the VNB project.

This repository is intended to hold a trivial NAT-box developed by a third
party. VNB will be applied to the code in order to evaluate the VNB usage
experience.

## Dependencies
### Functional dependencies
You will need [DPDK](http://dpdk.org) to build and run the NAT box.
### Verification dependencies
You need custom Klee, custom VeriFast and the binder sauce - VNB toolchain if
you want to verify the code crash-freedom.

## How to build

Download and build dpdk, then:

```bash
$ export RTE_SDK=/path/to/dpdk
$ make
```

## How to run
See testbed/nat.sh for the example running the NAT-box.
If you want to see that example in action, you will need
[Vagrant](http://vagrantup.com) with [VirtualBox](http://virtualbox.org)
provider. Then:

```bash
$ cd testbed
$ vagrant up
$ ./test-nat.sh
```

This will start 3 virtual machines (client, medium and server), start the
NAT box in the medium and start a web server in the server. `test-nat.sh` then
attempts to download a page from that server at the client VM.

## Cmd-line arguments
As common across DPDK apps, this NAT uses 2-part argument structure:

```bash
$ ./build/nat -c 0x1 -n 2 -- -p 0x3 --wan 0 --expire 10 --max-flows 1024 --starting-port 1025  --extip 192.168.33.2 --eth-dest 0,08:00:27:53:8b:38 --eth-dest 1,08:00:27:c1:13:47
```

- `--` separates DPDK framework parameters from the application specific ones.
- `-c` sets a bit mask on the cores to use. Here we use only the first core.
- `-n` is the number of memory channels. Here we have 2: 1 input and 1 output

Then go the application specific arguments:
- `--wan` - the number of the "external" port: the NIC facing the "global"
  network
- `--expire` - expiration time in seconds for the flow entries. After this
  period of inactivity the flow will be removed from the table
- `--max-flows` - the flow table capacity: the number of concurrent active flows
  that the NAT will support
- `--starting-port` - the smallest port to be allocated for a new flow. As this
  is a NAPT, it uses TCP/UDP ports to differentiate between flows. It will never
  use ports below this value (used to avoid clashes with the preallocated ports,
  like 80, 22, 20 etc.)
- `--extip` - the external IP addres of the nat. Used in the source address
  rewriting.
- `--eth-dest` - ehternet address of the first router on the corresponding end.
