contacts = []

def add(name, phone, email):
    contacts.append({"name": name, "phone": phone, "email": email})

def search(name):
    return next((c for c in contacts if c["name"].lower() == name.lower()), None)

def update(name, phone=None, email=None):
    c = search(name)
    if c:
        if phone:
            c["phone"] = phone
        if email:
            c["email"] = email
        return True
    return False

def delete(name):
    c = search(name)
    if c:
        contacts.remove(c)
        return True
    return False

add("Anaya Rao", "9876543210", "anaya@example.com")
add("Rohan Das", "9123456780", "rohan@example.com")
print("Contacts:", [c["name"] for c in contacts])
print("Search Anaya phone:", search("Anaya Rao")["phone"])
update("Anaya Rao", phone="9988776655")
print("Updated Anaya phone:", search("Anaya Rao")["phone"])
print("Deleted Rohan:", delete("Rohan Das"))
print("Contacts remaining:", [c["name"] for c in contacts])
