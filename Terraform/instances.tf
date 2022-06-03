resource "aws_instance" "webservers" {
	count = length(var.subnets_cidr) 
	ami = var.webservers_ami
	instance_type = var.instance_type
	security_groups = [aws_security_group.webservers.id]
	subnet_id = element(aws_subnet.public.*.id,count.index)
	user_data = file("install_apache.sh")
	key_name = "${aws_key_pair.keypair.key_name}"

	tags = {
	  Name = "Server-${count.index}"
	}
}

resource "aws_key_pair" "keypair" {
        key_name = "shivakumar"
        public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDh7hluJ4p/s146v0XXMn4KCSzyqKpZVy2GwG+iEG4AwhPJ9OZnwk9ps1AS9Q6q/UsOMXaMfvdqmMYV8HheaVvxc5peNB0hcXoi9al9VhrAJZYT/gT4KchdOUFCcVij/wfTCM6p0CQdGCPan6nldNwQ7SI0GNUVe0PFqbL0KVKbfdZ5DfOgnKL5u3oZ7ncfRIdE7G38GXlb8r+wvN8Hs61LcpCY8smxUAqgp50GXlU8Ernv/LNy/LdvMk24a5XwtH+dj60378oBRhjLQU6FYbysGIytknNgKnnS+/mG6eNylnOVjEq6d8dqKskKnpDgmHtjilalkVMBAiIfkYw1dL+V+xGtN2e5CSFYNqk1lHQXWlO/vpY+aYTuk3N25JgB8Xkc2kIsGkMHc73VEvklccccbb9OtC4Zb0cVO7LOY14oYIgo92ly7ZsWrqawQmSpl+XFpF8JVlb1VkC4ZLx86kyOGD1VHCrBhjvnLexFwFziOtGpvLnBJgMaktX71y/RFT8= shivakumar@shivakumar-HP-Laptop-15s-du3xxx"
}
