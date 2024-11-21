from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.validators import MinValueValidator, MaxValueValidator, MinLengthValidator
from medical.models import DoctorSpeciality 

class Gender(models.TextChoices):
    MALE = 'MALE', 'Male'
    FEMALE = 'FEMALE', 'Female'

class Role(models.TextChoices):
    DOCTOR = 'DOCTOR', 'Doctor'
    PATIENT = 'PATIENT', 'Patient'
    HOSPITAL_AGENT = 'HOSPITAL_AGENT', 'Hospital Agent'
    ACCOMMODATION_PROVIDER = 'ACCOMMODATION_PROVIDER', 'Accommodation Provider'
    CLINIC_AGENT = 'CLINIC_AGENT', 'Clinic Agent'

class User(AbstractUser):
    cin = models.IntegerField(unique=True)
    birthday = models.DateField()
    gender = models.CharField(max_length=10, choices=Gender.choices)
    profile_picture = models.URLField(null=True, blank=True)
    phone_number = models.CharField(max_length=8, validators=[MinLengthValidator(8)])
    role = models.CharField(max_length=30, choices=Role.choices)

class Patient(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    medical_history = models.TextField()
    feedback = models.TextField(blank=True)

class Doctor(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    consultation_fee = models.DecimalField(max_digits=10, decimal_places=2)
    speciality = models.ForeignKey(DoctorSpeciality, on_delete=models.PROTECT)
    experience_years = models.IntegerField()
    recommendation_rate = models.FloatField(validators=[MinValueValidator(0), MaxValueValidator(5)])
   