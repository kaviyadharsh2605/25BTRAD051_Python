import math

print("Area Calculation Program")
print("-" * 40)
length = 10
breadth = 5
area_rect = length * breadth
print(f"Enter length of rectangle: {length}")
print(f"Enter breadth of rectangle: {breadth}")
print(f"Area of Rectangle = {area_rect}")
print("-" * 40)
radius = 7
area_circle = math.pi * radius ** 2
print(f"Enter radius of circle: {radius}")
print(f"Area of Circle = {area_circle:.2f}")
print("-" * 40)
base = 8
height = 6
area_tri = 0.5 * base * height
print(f"Enter base of triangle: {base}")
print(f"Enter height of triangle: {height}")
print(f"Area of Triangle = {area_tri}")
