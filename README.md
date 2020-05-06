Running the followin script will setup a docker enviroment and call several scripts
    "sh run_use_case.sh"

* It builds a Docker env.
* Vault is automatically initialised and authenticated as root.
* Consul is used as storage
* Mysql is mounted and uses Database Secrets Engine
* Dynamic secretsa are written and read
* Vault read only policy is applied for mysql credentials.
* Envconsul is used in conjunction with the python script template provided.


UseCase
 
Locally or on AWS, manually or automatically :
 * Set up Vault (in non-dev mode), using a config.hcl that you would have created beforehand. Use Consul as a storage backend.
 * Initialise the Vault and authenticate as root.
 * Understand how to read/write secrets
 * Mount the MySQL Secret Engine and find a way to generate readonly credentials for MYSQL (Hint: Dynamic Secret)
 * Create a policy that only allow to “generate readonly credentials for MYSQL” and assign it to a new token. Confirm this new token can’t do anything else.

Below is an incomplete python script, find ways to complete it : 
 * use EnvConsul to inject secrets into the script and read from getFromEnv()
 * write an API Call to get MySQL credentials from Vault.
 
 
code template:
 
import os, MySQLdb, requests, json
 
def getFromEnv():
    env_var = str(os.environ['ENV_VAR'])
 
    print "---FROM ENV---"
    print "Your Secret :", env_var
    print "\n"
 
def getFromAPI():
    # response = requests.get("http://localhost:8200" + " ..... ", headers = {"X-Vault-Token": YOUR_TOKEN})
 
    # 200 = OK, other = NOK
    if(response.ok):
       ....
    else:
        Resp.raise_for_status()
 
getFromEnv()
