# Job Developer | Vaga para desenvolder
Developer test. Not for commercial use

## Instructions | Instruções
App: https://meus-pedidos-dev-job.herokuapp.com/contact
### English description

Application is avaliable at [herokuapp.com](https://meus-pedidos-dev-job.herokuapp.com/contact).
Path: ***/contact***.

If you would like to create an instance and/or host in another place, be aware that **for development mode** purpose you should create a *yaml_config.yml* file and provide some information, that will be used by the application to configure Pony *(ruby gem)*.

**For production mode** purpose be aware of using environment variables for some of the following information: smtp (if it would be used), username, password and domain.

Check **controllers/contact_controller.rb** if you want to know how this application interact with *environment variables* or *yaml_config.yml* file.

### Descrição em português

Application está disponível em [herokuapp.com](https://meus-pedidos-dev-job.herokuapp.com/contact).
Caminho: ***/contact***.

Se você gostaria de criar uma instância e/ou hospedar em outro lugar, esteja ciente que **para desenvolvimento** você deve criar um arquivo por nome *yaml_config.yml* e providenciar algumas informações, as quais serão usadas pela aplicação para configurar Pony *(ruby gem)*.

Para o **modo desenvolvimento** esteja ciente de usar variáveis de ambiente para algumas das seguintes informações: smtp (se for usado), username, password e domain.

Confira **controllers/contact_controller.rb** se você quer saber como essa aplicação faz uso de *ambientes de variáveis* ou arquivo *yaml_config.yml*.

### yaml_config.yml example
```yaml
development:
  GMAIL:
    USERNAME: user_name_value
    PASSWORD: password_value
    DOMAIN: localhost.localdomain
    EMAIL_ADDRESS: smtp.gmail.com
```
