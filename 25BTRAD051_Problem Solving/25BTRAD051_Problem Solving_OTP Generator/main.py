import random

def generate_otp():
    otp = random.randint(100000, 999999)
    return otp

generated_otp = generate_otp()
print("==================================")
print("       OTP GENERATOR SYSTEM       ")
print("==================================")
print("Generated OTP:", generated_otp)
print("==================================")
