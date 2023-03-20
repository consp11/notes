ЭТО КОПИЯ ФАЙЛА

echo > /inRam/avh.txt
echo > /inRam/avu.txt

notepadqq /inRam/avh.txt &
timeout 8s cat
notepadqq /inRam/avu.txt &

# На всякий случай
disown -a

clear

