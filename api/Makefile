account = $(shell aws sts get-caller-identity --query "Account" --output text)
stage = dev
include stages/$(stage)
image = $(account).dkr.ecr.us-east-1.amazonaws.com/apiapp:$(version)
login:
	@aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(account).dkr.ecr.us-east-1.amazonaws.com

build:
	@docker build -t $(image) .

push: login
	@docker push $(image)

deploy:
	@echo "namespace variable is set to $(namespace)"
	@cat deployment.yaml | sed "s|IMAGEVERSION|$(version)|g;s|NAMESPACE|$(namespace)|g;s|ACCOUNT|$(account)|g" | kubectl apply -f -
#salam
