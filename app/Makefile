install_dependencies:
	@pip install -r requirements.txt -t ./package

build_zip:
	@cd ./package && zip -r ../my_deployment_package.zip .
	@zip my_deployment_package.zip ./lambda_function.py
