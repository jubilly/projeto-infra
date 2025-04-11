## Apresentação

Projeto foi desenvolvido na disciplina de Infraestrutura da pós-graduação de Desenvolvimento Web 2024. Hã um backend para disponibilizar os produtos para o cliente, que por sua vez é um HTML que poderá visualizar os produtos da api e realizar a adição de 1 produtos por vez no carrinho, até zerar a quantidade do mesmo.

## Tecnologias

Frontend
    Javascript
    HTML
    CSS

Backend
    NodeJS
    ExpressJS
    MySQL

Infra
    AWS
    Terraform

## Backend

Crie um arquivo .env na pasta backend, copie as chaves conforme o arquivo .env.example. Popule as chaves com os valores.

Na raiz do projeto, rode o comando

        npm run server


## Como subir para a nuvem

- Conectar na aws usando a cli aws configure
- Gerar chave de segurança de Pares dentro da aws EC2
    - (WINDOWS) Mudar a permissão do arquivo Pares de chave para o usuário ubuntu

        icacls.exe “mypemfile.pem” /reset
        icacls.exe “mypemfile.pem” /grant:r USE_PC_NAME:(r)”
        icacls.exe “mypemfile.pem” /inheritance:r

- No terminal do projeto, ir para pasta iac e rodar os comandos:

        terraform init
        terraform apply

### Configurações Backend

- Copiar os arquivos da api via scp para o servidor

        scp -i posweb2024.pem ./backend/myapi.py ubuntu@EC2_PUBLIC_IP:/home/ubuntu

- Conectar no E2C via ssh

        mysql -h URL_PUBLIC_RDS -u DATABASE_USERNAME -p DATABASE_INSTANCE_NAME


- Criar o banco de dados e tabela pelo terminal da máquina E2C

        CREATE TABLE Product (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            description TEXT,
            price DECIMAL(10, 2) NOT NULL,
            stock INT DEFAULT 0,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        );


        INSERT INTO Product (name, description, price, stock) VALUES
        ('Produto A', 'Descrição do Produto A', 10.99, 5),
        ('Produto B', 'Descrição do Produto B', 15.49, 8),
        ('Produto C', 'Descrição do Produto C', 7.99, 12),
        ('Produto D', 'Descrição do Produto D', 25.00, 15),
        ('Produto E', 'Descrição do Produto E', 3.50, 20),
        ('Produto F', 'Descrição do Produto F', 12.75, 18),
        ('Produto G', 'Descrição do Produto G', 9.99, 10),
        ('Produto H', 'Descrição do Produto H', 19.99, 14),
        ('Produto I', 'Descrição do Produto I', 5.00, 7),
        ('Produto J', 'Descrição do Produto J', 8.25, 13);


### Configurações Frontend

- O frontend precisa estar dentro da pasta /var/www/html

        ls -ls /var/www/
        chown ubuntu /var/www/html

        scp -i posweb2024.pem ./frontend/index.html ubuntu@EC2_PUBLIC_IP:/var/www/html/