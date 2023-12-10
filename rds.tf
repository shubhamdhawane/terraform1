#############################
# DB Subnet Group creation
#############################
resource "aws_db_subnet_group" "db_sub_group" {
  name        = "db-subnet-group"
  description = "db-subnet-group-for-rds-server"
  subnet_ids  = [aws_subnet.skyage-database-subnet-1.id, aws_subnet.skyage-database-subnet-2.id]
  tags = {
    Name = "My-DB-subnet-group"
  }
}

#####################
# db_instance
#####################
resource "aws_db_instance" "db_instance" {
  identifier               = "rds-server"
  engine                   = "mysql"
  db_name                  = "skyage_RDS_DB"
  username                 = "admin"
  password                 = "admin"
  instance_class           = "db.t3.micro"
  allocated_storage        = 20
  db_subnet_group_name     = aws_db_subnet_group.db_sub_group.id
  multi_az                 = false
  vpc_security_group_ids   = [aws_security_group.skyage-DB-SG.id]
  availability_zone        = "us-east-1"
  port                     = 3306
  publicly_accessible      = false
  skip_final_snapshot      = true
  delete_automated_backups = true
}