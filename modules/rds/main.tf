# create the subnet group for the rds instance
resource "aws_db_subnet_group" "rds_sg" {
  name         = "database subnet"
  subnet_ids   = [var.private_data_subnet_id[0], var.private_data_subnet_id[1]]
  description  = "subnet group for db instances"

  tags   = {
    Name = "DB-Subnet"
  }
}

# create the rds instance
resource "aws_db_instance" "rds" {
  count                   = var.rds_instances_count
  engine                  = "mysql"
  engine_version          = "8.0.31"
  multi_az                = false
  identifier              = "rds-db-instance-${count.index}"
  username                = "azeezs1"
  password                = "Aa123456!"
  instance_class          = "db.t2.micro"
  allocated_storage       = 200
  db_subnet_group_name    = aws_db_subnet_group.rds_sg.name
  vpc_security_group_ids  = [var.private_security_group_id]
  db_name                 = "applicationdb${count.index}"
  skip_final_snapshot     = true
  availability_zone       = var.availability_zones_names[count.index]
}
