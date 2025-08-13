#!/bin/bash

echo "🚀 Deployando Quiz Code para Firebase Hosting..."
 

# Build do projeto web
echo "🔨 Fazendo build do projeto..."
flutter build web 

if [ $? -eq 0 ]; then
    echo "✅ Build concluído com sucesso!"
    
    # Deploy no Firebase
    echo "🌐 Fazendo deploy no Firebase..."
    firebase deploy --only hosting
    
    if [ $? -eq 0 ]; then
        echo "🎉 Deploy concluído com sucesso!"
    else
        echo "❌ Erro no deploy do Firebase"
        exit 1
    fi
else
    echo "❌ Erro no build do projeto"
    exit 1
fi 