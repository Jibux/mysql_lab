# MySQL simple lab

Setup 2 MySQL instances in Docker containers.
The 2 containers are listening to differents ports (3306 and 3307).

## Start lab

```bash
./start_lab.sh
```

## Stop lab

```bash
./stop_lab.sh
```

## Init lab

Creates MySQL master-slave replication between the 2 instances.
`3306 instance` is master and `3307 instance` is the slave.


```bash
./init_lab.sh
```

## Client prompts

### `3306 instance`

```bash
./my3306.sh
```

### `3307 instance`

```bash
./my3307.sh
```

