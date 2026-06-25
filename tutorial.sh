


echo "======================================================================="
echo "   GUIA PASSO A PASSO: TOPOLOGIA E CONFIGURAÇÃO COMPLETA DO LAB"
echo "======================================================================="
echo ""


echo "-----------------------------------------------------------------------"
echo "PASSO 1: CONSTRUÇÃO DA TOPOLOGIA FÍSICA"
echo "-----------------------------------------------------------------------"
echo "Monte a estrutura exatamente como na imagem do seu cenário:"
echo "1. [Roteador 2911] <---> Conectado via cabo cruzado/direto ao [Server0]"
echo "   * Porta do Roteador: GigabitEthernet0/1"
echo "   * Porta do Servidor: FastEthernet0"
echo ""
echo "2. [Roteador 2911] <---> Conectado via cabo direto ao [Switch1]"
echo "   * Porta do Roteador: GigabitEthernet0/0"
echo "   * Porta do Switch: FastEthernet0/1"
echo ""
echo "3. [Switch1] <---> Conectado via cabo direto ao [Access Point0]"
echo "   * Porta do Switch: FastEthernet0/6"
echo "   * Porta do AP: Port 0"
echo ""
echo "4. [Switch1] <---> Conectado via cabo direto aos [PCs 0, 1, 2 e 3]"
echo "   * Portas do Switch: FastEthernet0/2 até FastEthernet0/5"
echo ""
echo "5. [PCs 4, 5, 6 e 7] <---> Conectados via Wi-Fi ao [Access Point0]"
echo "   * Lembre-se: Desligar o PC -> Remover placa Fa0 -> Inserir WMP300N -> Ligar PC"
echo ""

read -p "Após montar o cenário físico, aperte [ENTER] para ver os comandos do Roteador..."

clear
echo "-----------------------------------------------------------------------"
echo "PASSO 2: CONFIGURAÇÃO DO ROTEADOR (ROUTER1) - COPIE E COLE NA CLI"
echo "-----------------------------------------------------------------------"
echo "Abra a aba CLI do seu Router1"
echo ""

cat << 'EOF'
enable
configure terminal

! --- 1. CONFIGURAÇÃO DA REDE LOCAL (LAN) ---
interface GigabitEthernet0/0
 description Interface do Laboratório (Switch)
 ip address 192.168.1.1 255.255.255.0
 no shutdown
exit

! --- 2. CONFIGURAÇÃO DO SERVIDOR DHCP PARA OS PCS ---
no ip dhcp pool LAB_INFO
ip dhcp pool LAB_INFO
 network 192.168.1.0 255.255.255.0
 default-router 192.168.1.1
 dns-server 8.8.8.8
exit

! --- 3. CONFIGURAÇÃO DA ROTA PARA O GOOGLE (SERVER OU LOOPBACK) ---
interface GigabitEthernet0/1
 description Interface de Saida para a Internet (Google)
 ip address 8.8.8.1 255.255.255.0
 no shutdown
exit

interface loopback 0
 ip address 8.8.8.8 255.255.255.255
exit

end
write
EOF


echo "-----------------------------------------------------------------------"
echo "PASSO 3: CONFIGURAÇÃO DO SERVIDOR (SERVER0 - GOOGLE)"
echo "-----------------------------------------------------------------------"
echo "Clique no Server0, vá em Desktop > IP Configuration e defina staticamente:"
echo ""
echo "  * IP Address:    8.8.8.8"
echo "  * Subnet Mask:   255.255.255.0"
echo "  * Default Gateway: 8.8.8.1"
echo ""




echo "-----------------------------------------------------------------------"
echo "PASSO 4: ATIVAÇÃO DO DHCP NOS PCS"
echo "-----------------------------------------------------------------------"
echo "Em todos os 8 PCs (PC0 até PC7):"
echo "1. Vá em Desktop > IP Configuration."
echo "2. Altere para 'Static' por 2 segundos e depois volte para 'DHCP'."
echo "3. Certifique-se de que o IP recebido é algo como 192.168.1.X."
echo ""


echo "-----------------------------------------------------------------------"
echo "PASSO 5: ANÁLISE DE PACOTES NO MODO SIMULAÇÃO (VISUALIZANDO O PING)"
echo "-----------------------------------------------------------------------"
echo "Para ver os pacotes ICMP (Ping) trafegando passo a passo pela rede:"
echo ""
echo "1. MUDAR PARA O MODO SIMULAÇÃO:"
echo "   No canto inferior direito da tela, clique na aba 'Simulation'"
echo "   (ou use o atalho Shift + S). O relógio do cenário vai congelar."
echo ""
echo "2. FILTRAR APENAS O PING:"
echo "   No painel de simulação que se abriu à direita, clique em 'Edit Filters'"
echo "   e certifique-se de deixar marcado APENAS o protocolo ICMP."
echo ""
echo "3. DISPARAR O COMANDO:"
echo "   Abra o Command Prompt de qualquer PC (ex: PC0) e digite o ping:"
echo "      > ping 8.8.8.8"
echo "   (Repare que o prompt vai travar, pois a simulação está pausada)."
echo ""
echo "4. CONTROLE E QUANTIDADE DE PACOTES:"
echo "   * Um envelope colorido (pacote ICMP Echo Request) surgirá no PC0."
echo "   * No painel da direita, clique no botão 'Play' (Capture/Forward) "
echo "     ou aperte a tecla de espaço para ver o pacote se mover."
echo "   * Acompanhe o trajeto: PC -> Switch -> Roteador -> Servidor Google."
echo "   * O Servidor vai gerar o pacote de resposta (Echo Reply) fazendo o"
echo "     caminho inverso de volta para o PC."
echo "   * Contagem padrão: O comando gera 4 pacotes no total. Você precisará"
echo "     avançar a simulação até que todos os 4 ciclos terminem."
echo ""


echo "-----------------------------------------------------------------------"
echo "PASSO 6: RETORNANDO PARA O MODO REALTIME"
echo "-----------------------------------------------------------------------"
echo "Após analisar a troca de mensagens e ver os 4 pacotes finalizados:"
echo ""
echo "1. Clique na aba 'Realtime' no canto inferior direito (atalho Shift + R)."
echo "2. O tempo voltará a rodar normalmente."
echo "3. Olhe o Command Prompt do seu PC: ele exibirá o relatório final das"
echo "   4 mensagens enviadas e 4 recebidas com sucesso!"
echo ""
echo "-----------------------------------------------------------------------"
echo "               LABORATÓRIO CONCLUÍDO E HOMOLOGADO!"
echo "======================================================================="