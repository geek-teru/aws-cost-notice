FROM public.ecr.aws/lambda/python:3.13

# Copy function code
COPY package ${LAMBDA_TASK_ROOT}

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "cost_notice.lambda_handler" ]