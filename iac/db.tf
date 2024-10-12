resource "aws_db_instance" "ecommerce_db" {
  allocated_storage    = 10
  db_name              = "ecommerce"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "myapp_user"
  password             = "myapp_passwd"
  parameter_group_name = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.db_ecommere_sg.id]
  skip_final_snapshot  = true
}

resource "aws_security_group" "db_ecommere_sg" {
  name        = "db_ecommerce"
  description = "Allow MYDB inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "db_ecommere_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "db_ecommerce_allow_mysql" {
  security_group_id = aws_security_group.db_ecommere_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_mydb" {
  security_group_id = aws_security_group.db_ecommere_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}