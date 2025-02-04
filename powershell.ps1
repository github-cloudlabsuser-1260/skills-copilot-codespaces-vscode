# Variables
$resourceGroupName = "myResourceGroup"
$location = "EastUS"
$vmName = "myVM"
$adminUsername = "azureuser"
$adminPassword = "P@ssw0rd1234!"  # Ensure this meets Azure's password complexity requirements
$vmSize = "Standard_DS1_v2"
$networkName = "myVNet"
$subnetName = "mySubnet"
$ipName = "myPublicIP"
$nicName = "myNIC"
$imagePublisher = "Canonical"
$imageOffer = "UbuntuServer"
$imageSku = "18.04-LTS"

# Login to Azure
Connect-AzAccount

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a virtual network
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Location $location -Name $networkName -AddressPrefix "10.0.0.0/16"

# Create a subnet
$subnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.0.0/24" -VirtualNetwork $vnet
$vnet | Set-AzVirtualNetwork

# Create a public IP address
$publicIp = New-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Location $location -Name $ipName -AllocationMethod Dynamic

# Create a network interface
$nic = New-AzNetworkInterface -ResourceGroupName $resourceGroupName -Location $location -Name $nicName -SubnetId $subnet.Id -PublicIpAddressId $publicIp.Id

# Specify the VM configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize |
    Set-AzVMOperatingSystem -Linux -ComputerName $vmName -Credential (New-Object System.Management.Automation.PSCredential ($adminUsername, (ConvertTo-SecureString $adminPassword -AsPlainText -Force))) |
    Set-AzVMSourceImage -PublisherName $imagePublisher -Offer $imageOffer -Skus $imageSku -Version "latest" |
    Add-AzVMNetworkInterface -Id $nic.Id

# Create the VM
New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vmConfig