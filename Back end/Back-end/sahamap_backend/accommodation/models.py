from django.db import models
from users.models import Patient,User
from django.core.validators import MinValueValidator, MaxValueValidator


class AccommodationType(models.TextChoices):
    HOTEL = 'HOTEL', 'Hotel'
    APARTMENT = 'APARTMENT', 'Apartment'
    GUEST_HOUSE = 'GUEST_HOUSE', 'Guest House'

class Accommodation(models.Model):
    provider = models.ForeignKey(User, on_delete=models.CASCADE)
    #Location of the Accommodation
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
    
    type = models.CharField(max_length=20, choices=AccommodationType.choices)
    rooms_number = models.IntegerField()
    description = models.TextField()
    photos = models.JSONField()  # Store array of URLs
    availability = models.BooleanField(default=True)
    night_price = models.DecimalField(max_digits=10, decimal_places=2)
    rate = models.FloatField(validators=[MinValueValidator(0), MaxValueValidator(5)])

class AccommodationReservation(models.Model):
    accommodation = models.ForeignKey(Accommodation, on_delete=models.CASCADE)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    start_date = models.DateField()
    end_date = models.DateField()