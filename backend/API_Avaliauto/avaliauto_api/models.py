from django.db import models
from django.contrib.auth.models import AbstractUser,BaseUserManager
class Type(models.Model):
    description = models.CharField(max_length=100)

    def __str__(self):
        return str(self.description)

class UserManager(BaseUserManager):
    def create_user(self, email, password=None):
        if not email:
            raise ValueError('Usuários devem ter um endereço de email')

        user = self.model(
            email=self.normalize_email(email),
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password):
        user = self.create_user(
            email,
            password=password,
        )
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user

class User(AbstractUser):
    email = models.EmailField(max_length=255,unique=True)
    #username = None
    username = models.CharField(max_length=255,default="user")
    password = models.CharField(max_length=255)
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True) 
    tel = models.CharField(max_length=11,null=False,blank=False)
    type = models.ForeignKey(Type, on_delete= models.CASCADE,default="1")

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []
    #REQUIRED_FIELDS = ['username']

    objects = UserManager()

    def __str__(self):
        return self.email + " - "+self.first_name
        

class Consultancy(models.Model):
    data_hora = models.DateTimeField()
    detail = models.CharField(max_length=255,null=True,blank=True)
    cep = models.CharField(max_length=8)
    street = models.CharField(max_length=255)
    number = models.CharField(max_length=50)
    district = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    client = models.ForeignKey(User, on_delete=models.CASCADE,related_name="client")
    mechanical = models.ForeignKey(User, on_delete=models.CASCADE,related_name="mechanical",null=True,blank=True)
    status = models.CharField(max_length=50,default="pendente")
    # pendente: consultoria criada por um cliente
    # aceita: consultoria aceita por um mecânico
    # finalizada: consultoria finalizada após a avaliação de um mecânico
    vehicle_model = models.CharField(max_length=255)
    vehicle_year = models.IntegerField(null=True,blank=True)

    def __str__(self):
        return str(self.data_hora) + " - "+self.city

    class Meta:
        ordering = ['data_hora']


class Review(models.Model):
    star_motor = models.IntegerField()
    star_suspensao = models.IntegerField()
    star_pneus = models.IntegerField()
    star_pintura = models.IntegerField()
    comment_motor = models.CharField(max_length=300)
    comment_suspensao = models.CharField(max_length=300)
    comment_pneus = models.CharField(max_length=300)
    comment_pintura = models.CharField(max_length=300)
    consultancy = models.OneToOneField(Consultancy, on_delete=models.CASCADE,related_name="consultancy")

    def __str__(self):
        return self.id