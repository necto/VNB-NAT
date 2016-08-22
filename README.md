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

