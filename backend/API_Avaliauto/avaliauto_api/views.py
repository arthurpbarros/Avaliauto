from rest_framework.decorators import action
from django.views.decorators.csrf import csrf_exempt
from django.db.models import Q
from avaliauto_api.models import *
from avaliauto_api.serializers import *
from rest_framework import viewsets,status
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.permissions import AllowAny, IsAuthenticated 
from django.contrib.auth import authenticate,logout

class TypeViewSet(viewsets.ModelViewSet):
    queryset = Type.objects.all()
    serializer_class = TypeSerializer
    permission_classes = (IsAuthenticated,) 
       
class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer 
    #permission_classes = (IsAuthenticated,)
    
    permission_classes_by_action = {
        "list": [IsAuthenticated], "retrieve": [IsAuthenticated],
        "create": [AllowAny], "destroy": [IsAuthenticated], 
        "update": [IsAuthenticated], "partial_update": [IsAuthenticated],
        "login": [AllowAny], "logout": [IsAuthenticated], "get_user_data": [IsAuthenticated]
    }

    def get_permissions(self):
        try:
            # return permission_classes depending on `action` 
            return [permission() for permission in self.permission_classes_by_action[self.action]]
        except KeyError: 
            # action is not set return default permission_classes
            return [permission() for permission in self.permission_classes]
    # POST        
    def create(self, request):
        serializer = self.serializer_class(data=request.data)
        if (serializer.is_valid()):
            # Salva o usuário
            serializer.save()
            return Response({'mensagem': 'Cadastro efetuado com sucesso!'},status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

    # PUT
    def update(self, request,pk=None):
        try:
            user = User.objects.get(pk=pk)
            user_logged = Session.user(request)
            #Checar se o usuário logado é tem o id da requisição ou é superusuário
            if(user_logged.id != user.id and not user_logged.is_superuser):
                return Response({'erro': 'Acesso não autorizado'},status=status.HTTP_401_UNAUTHORIZED)

            serializer = self.serializer_class(user,data=request.data,partial=True)
            if (serializer.is_valid()):
                #Atualiza o usuário
                serializer.update(user,validated_data=serializer.validated_data)
                return Response(serializer.data,status=status.HTTP_200_OK)
            else:
                return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
        except User.DoesNotExist:
            return Response({'erro': 'O usuário fornecido não existe'},status=status.HTTP_400_BAD_REQUEST)

    # PATCH
    def partial_update(self, request,pk=None):
        # Reusa função update que implementa o método PUT
        return self.update(request,pk)

    @csrf_exempt
    @action(detail=False, methods=['post'])
    def login(self, request):
        email = request.data['email']
        password = request.data['password']
    
        user = authenticate(username=email, password=password)
        if user is not None:
            token,created = Token.objects.get_or_create(user=user)
            print (token,created)
            return Response({'token': token.key,'user_type': user.type.id,'user_id': user.id, 'name': user.first_name},status=status.HTTP_200_OK)
        else:
            return Response ({'error': 'Email e/ou senhas inválidos'}, status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False,methods=['get'])
    def logout(self,request):
            request.user.auth_token.delete()
            logout(request)
            return Response({'message': 'Logout realizado com sucesso'})

    @action(detail=False,methods=['get'])
    def get_user_data(self,request):
        token = request.user.auth_token
        token_user_logged = Token.objects.get(pk=token.key)
        user_logged = User.objects.get(pk=token_user_logged.user_id)
        data = {
            'name': user_logged.first_name+" "+user_logged.last_name,
            'email': user_logged.email,
            'id': user_logged.id,
            'type': user_logged.type.id,
            'token': token.key
        }
        return Response(data)
             
class ConsultancyViewSet(viewsets.ModelViewSet):
    queryset = Consultancy.objects.all()
    serializer_class = ConsultancySerializer
    permission_classes = (IsAuthenticated,) 

    """
    def get_queryset(self,request):
        user = Session.user(request)
        return Consultancy.objects.filter(client=user) if user.type.id == 1 else Consultancy.objects.filter(Q(mechanical=user) | Q(status="pendente")) 
    """

    @action(detail=False,methods=["GET"])
    def list_custom(self,request):
        user = Session.user(request)
        consultancies = Consultancy.objects.filter(client=user) if user.type.id == 1 else Consultancy.objects.filter(Q(mechanical=user) | Q(status="pendente")) 
        consultancy_serializer = ConsultancySerializer(consultancies,many=True)
        return Response(consultancy_serializer.data,status=status.HTTP_200_OK) 

    @action(detail=False,methods=["GET"])
    def list_pending(self,request):
        user = Session.user(request)
        pending_consul = Consultancy.objects.filter(status="pendente",client=user) if user.type.id == 1 else Consultancy.objects.filter(status="pendente") 
        consultancy_serializer = ConsultancySerializer(pending_consul,many=True)
        return Response(consultancy_serializer.data,status=status.HTTP_200_OK)
        

    @action(detail=False,methods=["GET"])
    def list_accepted(self,request):
        user = Session.user(request)
        accepted_consul = Consultancy.objects.filter(status="aceita",client=user) if user.type.id == 1 else Consultancy.objects.filter(status="aceita",mechanical=user) 
        consultancy_serializer = ConsultancySerializer(accepted_consul,many=True)
        return Response(consultancy_serializer.data,status=status.HTTP_200_OK)


    @action(detail=False,methods=["GET"])
    def list_finished(self,request):
        user = Session.user(request)
        finished_consul = Consultancy.objects.filter(status="finalizada",client=user) if user.type.id == 1 else Consultancy.objects.filter(status="finalizada",mechanical=user)
        consultancy_serializer = ConsultancySerializer(finished_consul,many=True)
        return Response(consultancy_serializer.data,status=status.HTTP_200_OK)

class ReviewViewSet(viewsets.ModelViewSet):
    queryset = Review.objects.all()
    serializer_class = ReviewSerializer
    permission_classes = (IsAuthenticated,) 

    @action(detail=True,methods=["GET"])
    def get_by_consultancy(self,request,pk):
        try:
            review = Review.objects.get(consultancy=pk)
            review_serializer = ReviewSerializer(review)
            return Response(review_serializer.data,status=status.HTTP_200_OK)
        except Review.DoesNotExist:
            return Response ({'error': 'Não existe avaliação para essa consultoria'}, status=status.HTTP_404_NOT_FOUND)

class Session:
    def user(request):
        return request.user
