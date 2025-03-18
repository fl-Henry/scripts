
# Authentication
## Generate an SSH key
```bash
ssh-keygen -t rsa -b 4096 -C "fl.henry.jefferson@gmail.com"
```

## Read an ssh key
```bash
cat ~/.ssh/id_rsa.pub
```

## Test the Connection
```bash
ssh -T git@github.com
```

# Pull

```bash
git clone git@github.com:username/repository.git
```