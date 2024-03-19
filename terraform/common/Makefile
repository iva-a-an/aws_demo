#Make terraform plan
## TODO: Add better verification for new plan
plan:
	@echo "Terraform Plan"
	@terraform plan -out=plan.tfplan
	@terraform show ./plan.tfplan | grep " # "