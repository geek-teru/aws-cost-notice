def lambda_handler(event, context) -> str:
    print("test")
    return {"status": 200}


if __name__ == "__main__":
    lambda_handler("", "")
