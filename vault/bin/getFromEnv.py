import os, requests, json, MySQLdb as _mysql
 
def getFromEnv():
  mysql_pw = str(os.environ['mysql_creds_readonly_password'])
  mysql_user = str(os.environ['mysql_creds_readonly_username'])

  print "---FROM ENV---"
  print "MySQL username :", mysql_user
  print "MySQL password :", mysql_pw
 
def getFromAPI():
  readonly_token = str(os.environ['VAULT_TOKEN'])
  response = requests.get("http://vault:8200" + "/v1/mysql/creds/readonly", headers = {"X-Vault-Token": readonly_token})

  # 200 = OK, other = NOK
  if(response.ok):
    response_data = json.loads(response.content)['data']
    db=_mysql.connect('mysql', response_data['username'], response_data['password'])
    user_query = "select * from mysql.user"
    db.query(user_query)
    query_result=db.store_result()
    print(user_query)
    print(query_result.fetch_row(maxrows=0))
  else:
    response.raise_for_status()

getFromEnv()
getFromAPI()
