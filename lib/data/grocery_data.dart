class GroceryData {
  static List<Map<String, dynamic>> groceryProducts = [
    {
      "id": 1,
      "name": "Apple",
      "category": "Fruits",
      "price": 2.5,
      "quantity": 10,
      "unit": "kg",
      "inStock": true,
      "imageUrl":
          "https://imgs.search.brave.com/jo6FlF0CmeGcov0Bm0qR816eUJi975_8AaUOHzULLZQ/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTQ3/MzY3NjA2My9waG90/by9yZWQtYXBwbGVz/LW9uLXRoZS1tYXJr/ZXQtc3RhbGwuanBn/P3M9NjEyeDYxMiZ3/PTAmaz0yMCZjPVEw/Y0JPSzV3N3hLbXRS/cVhfTUptekRlU2h6/TGRFc1cyZVVTX0x1/UjhCbG89"
    },
    {
      "id": 2,
      "name": "Milk",
      "category": "Dairy",
      "price": 1.2,
      "quantity": 5,
      "unit": "liters",
      "inStock": true,
      "imageUrl":
          "https://imgs.search.brave.com/8WuMOEh70DOu1pCpi6nfwzTteCKlquwgQjylmSEXnnk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9j/bGFzc2ljLWdsYXNz/LWJvdHRsZS1taWxr/XzIzLTIxNTA3MzQ0/NTkuanBnP3NlbXQ9/YWlzX2h5YnJpZA"
    },
    {
      "id": 3,
      "name": "Bread",
      "category": "Bakery",
      "price": 1.8,
      "quantity": 15,
      "unit": "pieces",
      "inStock": true,
      "imageUrl":
          "https://imgs.search.brave.com/-yZlyfgFvf12ULR8hpp90Qs3WLJQN5cLZOzZeai4Q6Q/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA4LzkxLzQ3LzQ0/LzM2MF9GXzg5MTQ3/NDQ2Nl9TRGpYRW4w/ZGZtM0Z0TFRDUDdU/MFVvbmhqOGs3VDZw/Ry5qcGc"
    },
    {
      "id": 4,
      "name": "Rice",
      "category": "Grains",
      "price": 3.0,
      "quantity": 20,
      "unit": "kg",
      "inStock": true,
      "imageUrl":
          "https://imgs.search.brave.com/ktJ80-uUN6D0SpRV_l2asua8rdyrOkx6VkmPiITVk78/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTUz/NzM3ODQxL3Bob3Rv/L3JpY2UuanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPWxmTzdp/TFQwVXNERHpyYTB1/Qk9zTjFydnIyZDVP/RXRyRzJ1d2J0czMz/X2M9"
    },
    {
      "id": 5,
      "name": "Eggs",
      "category": "Dairy",
      "price": 2.0,
      "quantity": 12,
      "unit": "dozen",
      "inStock": false,
      "imageUrl":
          "https://imgs.search.brave.com/H7MrkB6DKmdgP-M1ryjGAuDfIQ3dVJVX8Tn8QAyX1wQ/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAyLzkzLzMxLzQ0/LzM2MF9GXzI5MzMx/NDQ0N19KZmtRRUdV/Y1pTMnhZck1RNFg1/RTZDcHlzTDNaNkM5/Ri5qcGc"
    },
    {
      "id": 6,
      "name": "Chicken",
      "category": "Meat",
      "price": 6.5,
      "quantity": 8,
      "unit": "kg",
      "inStock": true,
      "imageUrl":
          "https://imgs.search.brave.com/X7TCBIujzmDuFPdAJbPwGwLGiDPBpT5Nf1Nl9jm2fOk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM0/OTg3NTA0L3Bob3Rv/L2Jha2VkLWNoaWNr/ZW4uanBnP3M9NjEy/eDYxMiZ3PTAmaz0y/MCZjPVlvUW45NGVp/V251bEFQSk1LeTc2/ZE1KY0xJbllDaTA3/eEJ2M1AybVEyOG89"
    },
    {
      "id": 7,
      "name": "Tomato",
      "category": "Vegetables",
      "price": 2.0,
      "quantity": 7,
      "unit": "kg",
      "inStock": true,
      "imageUrl":
          "https://imgs.search.brave.com/8xilKcSpdQKBQTPTnp3svNxKbJIVoxlimu6mke8nR80/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9yZW5k/ZXIuZmluZWFydGFt/ZXJpY2EuY29tL2lt/YWdlcy9yZW5kZXJl/ZC9zZWFyY2gvcHJp/bnQvOC81LjUvYnJl/YWsvaW1hZ2VzLW1l/ZGl1bS01L3RvbWF0/by1ncmVlbmhvdXNl/LXNqby5qcGc"
    },
    {
      "id": 8,
      "name": "Salt",
      "category": "Spices",
      "price": 0.5,
      "quantity": 30,
      "unit": "kg",
      "inStock": true,
      "imageUrl":
          "https://imgs.search.brave.com/Y3VBg7njzjI_turTvtoTrFaUpIvzwxuI3rkWC2zNGZg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAxLzc0LzAxLzcy/LzM2MF9GXzE3NDAx/NzI0Nl92QVlGYmF4/ZERUcHV4V1ZnS3pj/TUpkdUFKUVUzMEY4/bS5qcGc"
    },
    {
      "id": 9,
      "name": "Sugar",
      "category": "Grains",
      "price": 2.8,
      "quantity": 25,
      "unit": "kg",
      "inStock": true,
      "imageUrl":
          "https://imgs.search.brave.com/pPB3jWe77bRVckzDsmaswvpBi7zrIniZVQedfpgJLkI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAwLzk2LzAzLzAw/LzM2MF9GXzk2MDMw/MDY2X3hBYTlheUFZ/dFdIMFdOUmNObE84/ck5Kczd5SFVJSnU1/LmpwZw"
    },
    {
      "id": 10,
      "name": "Orange Juice",
      "category": "Beverages",
      "price": 3.5,
      "quantity": 6,
      "unit": "liters",
      "inStock": false,
      "imageUrl":
          "https://imgs.search.brave.com/i-dv3cVydCDYbC89y-RLk8EBdLh07J53JfmY_Coxmno/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAxLzU5LzU4Lzc4/LzM2MF9GXzE1OTU4/Nzg3OF9sUzMzRkVN/UlhTZEpCZWFDbGQw/d25rNWJGVHFNR0lj/ci5qcGc"
    },
  ];
}
