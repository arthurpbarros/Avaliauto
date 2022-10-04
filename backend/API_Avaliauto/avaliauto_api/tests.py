from tkinter.messagebox import NO
from xml.dom import ValidationErr
from django.contrib.auth import authenticate
from urllib import request
from django.test import TestCase
from avaliauto_api.models import *
from avaliauto_api.views import *
from django.db.models import Q
from django.db import *
from django.core.exceptions import *

class TypeTest(TestCase):
    def test_create_type(self):
        type = Type.objects.create(description="Administrador")
        self.assertEqual(type,Type.objects.first())

    def test_list_types(self):
        Type(description="Cliente").save()
        Type(description="Mecânico").save()
        self.assertQuerysetEqual(Type.objects.all(),["<Type: Cliente>","<Type: Mecânico>"],ordered=False)

class CadastroUsuario(TestCase):
    def setUp(self) -> None:
        self.tipo = Type.objects.create(description="Cliente")

    def test_ct01_password_long(self):
        password="r"*256
        try:
            user = User.objects.create(email="usuario@email.com",password=password,first_name="usuario",last_name="sobrenome",type=self.tipo)
        except Exception as e:
            self.assertTrue("password" in str(e))

    def test_ct02_password_null(self):
        password=None
        try:
            User.objects.create(email="usuario@email.com",password=password,first_name="usuario",last_name="sobrenome",type=self.tipo)
        except Exception as e:
            self.assertTrue("password" in str(e))


    def test_ct03_email_long(self):
        email="r"*256+"@gmail.com"
        try:
            User.objects.create(email=email,password="password123",first_name="usuario",last_name="sobrenome",type=self.tipo)
        except Exception as e:
            self.assertTrue("email" in str(e))

    def test_ct04_email_null(self):
        email=None
        try:
            User.objects.create(email=email,password="password123",first_name="usuario",last_name="sobrenome",type=self.tipo)
        except Exception as e:
            self.assertTrue("email" in str(e))

    def test_ct05_email_duplicate(self):
        try:
            User.objects.create(email="usuario@gmail.com",password="password123",first_name="usuario",last_name="sobrenome",type=self.tipo)
            User.objects.create(email="usuario@gmail.com",password="password123",first_name="usuario2",last_name="sobrenome2",type=self.tipo)
        except Exception as e:
            self.assertTrue("email" in str(e))

    def test_ct06_first_name_long(self):
        first_name="r"*256
        try:
            User.objects.create(email="usuario@email.com",password="password123",first_name=first_name,last_name="sobrenome",type=self.tipo)
        except Exception as e:
            self.assertTrue("first_name" in str(e))

    def test_ct07_first_name_null(self):
        first_name=None
        try:
            User.objects.create(email="usuario@email.com",password="password123",first_name=first_name,last_name="sobrenome",type=self.tipo)
        except Exception as e:
            self.assertTrue("first_name" in str(e))

    def test_ct08_last_name_long(self):
        last_name="r"*256
        try:
            User.objects.create(email="usuario@email.com",password="password123",first_name="nome",last_name=last_name,type=self.tipo)
        except Exception as e:
            self.assertTrue("last_name" in str(e))

    def test_ct09_last_name_null(self):
        last_name=None
        try:
            User.objects.create(email="usuario@email.com",password="password123",first_name="nome",last_name=last_name,type=self.tipo)
        except Exception as e:
            self.assertTrue("last_name" in str(e))

    def test_ct10_user_ok(self):
        user = User.objects.create(email="usuario@email.com",password="password123",first_name="nome",last_name="sobrenome",type=self.tipo)
        self.assertEqual(user,User.objects.get(pk=user.id))


class ListarTodasConsultorias(TestCase):
    def test_listar_todas_as_consultorias(self):
        client_tipo = Type(description="Cliente")
        client_tipo.save()
        mechanical_tipo = Type(description="Mecânico")
        mechanical_tipo.save()

        client_user = User.objects.create(email="usuario@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)
        mechanical_user = User.objects.create(email="mecanico@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=mechanical_tipo)

        client_user2 = User.objects.create(email="usuario1@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)
        mechanical_user2 = User.objects.create(email="mechanical1@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)

        c1  = Consultancy.objects.create(data_hora="2022-02-22 15:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,vehicle_model="Fiat Uno")
        c2  = Consultancy.objects.create(data_hora="2022-02-22 16:00",cep="59002",street="Av Rodrigues Alves",number="12B",district="RN",city="Natal",client=client_user2,vehicle_model="Celta")
        c3  = Consultancy.objects.create(data_hora="2022-02-23 17:00",cep="59003",street="Av Tavares de Lira",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user,status="aceita",vehicle_model="Fiat Uno")
        c4  = Consultancy.objects.create(data_hora="2022-02-23 17:00",cep="59003",street="Av Tavares de Lira",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user2,status="aceita",vehicle_model="Pajero")
        c5  = Consultancy.objects.create(data_hora="2022-04-03 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user,status="aceita",vehicle_model="Corolla",)
        c6  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user2,status="aceita",vehicle_model="Corolla")
        c7  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user,status="finalizada",vehicle_model="Corolla")
        c8  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user2,status="finalizada",vehicle_model="Corolla")
        c9  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user,status="finalizada",vehicle_model="Corolla")
        c10 = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user2,status="finalizada",vehicle_model="Corolla")

        #Em relação ao mechanical_user
        list_consultancy = [c1,c2,c3,c5,c7,c9]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(Q(mechanical=mechanical_user) | Q(status="pendente")),ordered=False)
        #Em relação ao mechanical_user2
        list_consultancy = [c1,c2,c4,c6,c8,c10]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(Q(mechanical=mechanical_user2) | Q(status="pendente")),ordered=False)
        #Em relação ao client_user
        list_consultancy = [c1,c3,c4,c7,c8]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(client=client_user),ordered=False)
        #Em relação ao client_user2
        list_consultancy = [c2,c5,c6,c9,c10]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(client=client_user2),ordered=False)

class Listar_Consultorias_Pendentes(TestCase):
    def test_listar_consultorias_pendentes(self):
        STATUS = "pendente"

        client_tipo = Type(description="Cliente")
        client_tipo.save()
        mechanical_tipo = Type(description="Mecânico")
        mechanical_tipo.save()

        client_user = User.objects.create(email="usuario@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)
        mechanical_user = User.objects.create(email="mecanico@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=mechanical_tipo)

        client_user2 = User.objects.create(email="usuario1@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)
        mechanical_user2 = User.objects.create(email="mechanical1@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)

        c1  = Consultancy.objects.create(data_hora="2022-02-22 15:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,vehicle_model="Fiat Uno")
        c2  = Consultancy.objects.create(data_hora="2022-02-22 16:00",cep="59002",street="Av Rodrigues Alves",number="12B",district="RN",city="Natal",client=client_user2,vehicle_model="Celta")
        c3  = Consultancy.objects.create(data_hora="2022-02-23 17:00",cep="59003",street="Av Tavares de Lira",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user,status="aceita",vehicle_model="Fiat Uno")
        c4  = Consultancy.objects.create(data_hora="2022-02-23 17:00",cep="59003",street="Av Tavares de Lira",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user2,status="aceita",vehicle_model="Pajero")
        c5  = Consultancy.objects.create(data_hora="2022-04-03 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user,status="aceita",vehicle_model="Corolla",)
        c6  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user2,status="aceita",vehicle_model="Corolla")
        c7  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user,status="finalizada",vehicle_model="Corolla")
        c8  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user2,status="finalizada",vehicle_model="Corolla")
        c9  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user,status="finalizada",vehicle_model="Corolla")
        c10 = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user2,status="finalizada",vehicle_model="Corolla")

        #Em relação ao mechanical_user
        list_consultancy = [c1,c2]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(status=STATUS),ordered=False)
        #Em relação ao mechanical_user2
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(status=STATUS),ordered=False)
        #Em relação ao client_user
        list_consultancy = [c1]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(client=client_user,status=STATUS),ordered=False)
        #Em relação ao client_user2
        list_consultancy = [c2]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(client=client_user2,status=STATUS),ordered=False)

class Listar_Consultorias_Aceitas(TestCase):
    def test_listar_consultorias_aceitas(self):
        STATUS = "aceita"

        client_tipo = Type(description="Cliente")
        client_tipo.save()
        mechanical_tipo = Type(description="Mecânico")
        mechanical_tipo.save()

        client_user = User.objects.create(email="usuario@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)
        mechanical_user = User.objects.create(email="mecanico@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=mechanical_tipo)

        client_user2 = User.objects.create(email="usuario1@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)
        mechanical_user2 = User.objects.create(email="mechanical1@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)

        c1  = Consultancy.objects.create(data_hora="2022-02-22 15:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,vehicle_model="Fiat Uno")
        c2  = Consultancy.objects.create(data_hora="2022-02-22 16:00",cep="59002",street="Av Rodrigues Alves",number="12B",district="RN",city="Natal",client=client_user2,vehicle_model="Celta")
        c3  = Consultancy.objects.create(data_hora="2022-02-23 17:00",cep="59003",street="Av Tavares de Lira",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user,status="aceita",vehicle_model="Fiat Uno")
        c4  = Consultancy.objects.create(data_hora="2022-02-23 17:00",cep="59003",street="Av Tavares de Lira",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user2,status="aceita",vehicle_model="Pajero")
        c5  = Consultancy.objects.create(data_hora="2022-04-03 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user,status="aceita",vehicle_model="Corolla",)
        c6  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user2,status="aceita",vehicle_model="Corolla")
        c7  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user,status="finalizada",vehicle_model="Corolla")
        c8  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user2,status="finalizada",vehicle_model="Corolla")
        c9  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user,status="finalizada",vehicle_model="Corolla")
        c10 = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user2,status="finalizada",vehicle_model="Corolla")

        #Em relação ao mechanical_user
        list_consultancy = [c3,c5]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(status=STATUS,mechanical=mechanical_user),ordered=False)
        #Em relação ao mechanical_user2
        list_consultancy = [c4,c6]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(status=STATUS,mechanical=mechanical_user2),ordered=False)

        #Em relação ao client_user
        list_consultancy = [c3,c4]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(client=client_user,status=STATUS),ordered=False)

        #Em relação ao client_user2
        list_consultancy = [c5,c6]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(client=client_user2,status=STATUS),ordered=False)

class Listar_Consultorias_Finalizadas(TestCase):
    def test_listar_consultorias_finalizadas(self):
        STATUS = "finalizada"
        
        client_tipo = Type(description="Cliente")
        client_tipo.save()
        mechanical_tipo = Type(description="Mecânico")
        mechanical_tipo.save()

        client_user = User.objects.create(email="usuario@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)
        mechanical_user = User.objects.create(email="mecanico@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=mechanical_tipo)

        client_user2 = User.objects.create(email="usuario1@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)
        mechanical_user2 = User.objects.create(email="mechanical1@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)

        c1  = Consultancy.objects.create(data_hora="2022-02-22 15:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,vehicle_model="Fiat Uno")
        c2  = Consultancy.objects.create(data_hora="2022-02-22 16:00",cep="59002",street="Av Rodrigues Alves",number="12B",district="RN",city="Natal",client=client_user2,vehicle_model="Celta")
        c3  = Consultancy.objects.create(data_hora="2022-02-23 17:00",cep="59003",street="Av Tavares de Lira",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user,status="aceita",vehicle_model="Fiat Uno")
        c4  = Consultancy.objects.create(data_hora="2022-02-23 17:00",cep="59003",street="Av Tavares de Lira",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user2,status="aceita",vehicle_model="Pajero")
        c5  = Consultancy.objects.create(data_hora="2022-04-03 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user,status="aceita",vehicle_model="Corolla",)
        c6  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user2,status="aceita",vehicle_model="Corolla")
        c7  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user,status="finalizada",vehicle_model="Corolla")
        c8  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user2,status="finalizada",vehicle_model="Corolla")
        c9  = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user,status="finalizada",vehicle_model="Corolla")
        c10 = Consultancy.objects.create(data_hora="2022-04-01 08:00",cep="59001",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user2,mechanical=mechanical_user2,status="finalizada",vehicle_model="Corolla")

        #Em relação ao mechanical_user
        list_consultancy = [c7,c9]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(status=STATUS,mechanical=mechanical_user),ordered=False)
        #Em relação ao mechanical_user2
        list_consultancy = [c8,c10]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(status=STATUS,mechanical=mechanical_user2),ordered=False)
        #Em relação ao client_user
        list_consultancy = [c7,c8]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(client=client_user,status=STATUS),ordered=False)
        #Em relação ao client_user2
        list_consultancy = [c9,c10]
        self.assertQuerysetEqual(list_consultancy,Consultancy.objects.filter(client=client_user2,status=STATUS),ordered=False)

class SolicitarConsultoria(TestCase):
    def setUp(self) -> None:
        self.client_tipo = Type(description="Cliente")
        self.client_tipo.save()
        self.client_user = User.objects.create(email="usuario@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=self.client_tipo)

    def test_ct01_data_hora_invalid(self):
        data = "2018-10-AA 15:00"
        try:
            c1 = Consultancy.objects.create(data_hora=data,cep="59101521",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=self.client_user,vehicle_model="Fiat Uno")
        except ValidationError as e:
            self.assertTrue(data in str(e))
    
    def test_ct02_data_hora_null(self):
        data = None
        try:
            Consultancy.objects.create(data_hora=data,cep="59101521",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=self.client_user,vehicle_model="Fiat Uno")
        except Exception as e:
            self.assertTrue("data_hora" in str(e))

    def test_ct03_cep_max_lenght(self):
        cep = "581412369"
        try:
            c1 = Consultancy.objects.create(data_hora="2018-10-22 15:00",cep=cep,street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=self.client_user,vehicle_model="Fiat Uno")
        except Exception as e:
            self.assertTrue("cep" in str(e))

    def test_ct04_cep_null(self):
        cep = None
        try:
            c1 = Consultancy.objects.create(data_hora="2018-10-22 15:00",cep=cep,street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=self.client_user,vehicle_model="Fiat Uno")
        except Exception as e:
            self.assertTrue("cep" in str(e))

    def test_ct05_street_max_lenght(self):
        street = "Prudente de Morais"*100
        try:
            c1 = Consultancy.objects.create(data_hora="2018-10-22 15:00",cep="59880523",street=street,number="12B",district="RN",city="Natal",client=self.client_user,vehicle_model="Fiat Uno")
        except Exception as e:
            self.assertTrue("street" in str(e))

    def test_ct06_street_null(self):
        street = None
        try:
            c1 = Consultancy.objects.create(data_hora="2018-10-22 15:00",cep="59880523",street=street,number="12B",district="RN",city="Natal",client=self.client_user,vehicle_model="Fiat Uno")
        except Exception as e:
            self.assertTrue("street" in str(e))
    

    def test_ct07_ok(self):
        c1  = Consultancy.objects.create(data_hora="2018-10-22 15:00",cep="59101",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=self.client_user,vehicle_model="Fiat Uno")
        self.assertEqual(c1,Consultancy.objects.get(pk=c1.id))

class Aceitar_Consultoria(TestCase):
    def test_aceitar_consultoria(self):
        client_tipo = Type(description="Cliente")
        client_tipo.save()
        mechanical_tipo = Type(description="Mecânico")
        mechanical_tipo.save()

        client_user = User.objects.create(email="usuario@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)
        mechanical_user = User.objects.create(email="mecanico@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=mechanical_tipo)

        c1 = Consultancy.objects.create(data_hora="2018-08-13 10:00",cep="59101",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,vehicle_model="Ford EcoSport")
        c1.mechanical = mechanical_user
        c1.status = "aceitar"
        c1.save()

        self.assertEqual(c1,Consultancy.objects.get(pk=c1.id))

class Visualizar_Consultoria(TestCase):
    def test_visualizar_consultoria(self):
        client_tipo = Type(description="Cliente")
        client_tipo.save()
        mechanical_tipo = Type(description="Mecânico")
        mechanical_tipo.save()

        client_user = User.objects.create(email="usuario@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=client_tipo)
        mechanical_user = User.objects.create(email="mecanico@email.com",password="password123",first_name="usuario",last_name="sobrenome",type=mechanical_tipo)
        c1 = Consultancy.objects.create(data_hora="2018-08-13 10:00",cep="59101",street="Av Prudente de Morais",number="12B",district="RN",city="Natal",client=client_user,mechanical=mechanical_user,status="aceita",vehicle_model="Ford EcoSport")
        self.assertEqual(c1,Consultancy.objects.get(pk=c1.id))