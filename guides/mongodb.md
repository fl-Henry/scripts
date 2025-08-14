
## install
1. **Install dependencies** (gnupg, wget, curl):
   ```bash
   sudo apt update
   sudo apt-get install gnupg curl -y
   ```

2. **Add the MongoDB GPG key** to verify packages:
   ```bash
   curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
   ```

3. **Add the MongoDB repository** to your APT sources list:
   ```bash
   echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] http://repo.mongodb.org/apt/debian bookworm/mongodb-org/8.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
   ```

4. **Update the package database:**
   ```bash
   sudo apt update
   ```

5. **Install MongoDB:**
   ```bash
   sudo apt-get install -y mongodb-org
   ```

6. **Start and enable MongoDB service:**
   ```bash
   sudo systemctl start mongod
   sudo systemctl enable mongod
   ```

7. **Verify installation:**
   ```bash
   mongod --version
   ```


## manage

#### Run CLI
```bash
mongosh
```

#### Show db and collections
```mongosh
show dbs
show collections
```

#### Create a user
```mongosh
use admin
db.createUser({
  user: "learn_arg",
  pwd: "<your_password>",
  roles: [
    { role: "readWrite", db: "learn_argentinian" }
  ]
})
```