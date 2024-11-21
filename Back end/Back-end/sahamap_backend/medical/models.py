from django.db import models
from users.models import Patient,Doctor

class ServiceProvider(models.Model):
    name = models.CharField(max_length=255)
    phone_number = models.CharField(max_length=8)
    email = models.EmailField()
    
    #Location of the Accommodation
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
    
    type = models.CharField(max_length=50)  # Clinic, Hospital, Doctor Office, Laboratory, etc.

class DoctorsWorkplaces(models.Model) :
    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    service_provider = models.ForeignKey(ServiceProvider, on_delete=models.CASCADE)
    role = models.CharField(max_length=255, blank=True, null=True)  # e.g., 'Consultant', 'Surgeon'
    working_hours = models.CharField(max_length=255, blank=True, null=True)  # e.g., '9 AM - 5 PM'
    
    
class DoctorSpeciality(models.Model):
    name = models.CharField(max_length=100)

class AppointmentMode(models.TextChoices):
    IN_PLACE = 'IN_PLACE', 'In Place'
    ONLINE = 'ONLINE', 'Online'

class AppointmentStatus(models.TextChoices):
    DONE = 'DONE', 'Done'
    SCHEDULED = 'SCHEDULED', 'Scheduled'
    ON_HOLD = 'ON_HOLD', 'On Hold'
    CANCELED = 'CANCELED', 'Canceled'

class Appointment(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    service_provider = models.ForeignKey(ServiceProvider, on_delete=models.CASCADE)
    appointment_date = models.DateField()
    appointment_hour = models.TimeField()
    mode = models.CharField(max_length=20, choices=AppointmentMode.choices)
    status = models.CharField(max_length=20, choices=AppointmentStatus.choices)

class MedicalDocument(models.Model):
    appointment = models.ForeignKey(Appointment, on_delete=models.CASCADE)
    resume = models.TextField()
    diagnostics = models.TextField()
    instructions = models.TextField()