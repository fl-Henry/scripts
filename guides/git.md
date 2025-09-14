
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

```bash

git reset --hard origin/main
git fetch
git rebase origin/main

```

```bash
git pull origin main 
```

# Change git domain
```bash
awk '{gsub("gitlab.com", "ssh.boxexchanger.net")}1' .git/config > temp && mv temp .git/config
```

# merge main into a side branch
```
git checkout issue-30
git merge origin/main
```