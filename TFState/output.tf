output "prodsubnetid" {
    description = "This is for capturing Prod Subnet Id"
    value = azurerm_subnet.subnet1.id
}

output "devsubnetid" {
    description = "This is for capturing Dev Subnet Id"
    value = azurerm_subnet.subnet2.id
}