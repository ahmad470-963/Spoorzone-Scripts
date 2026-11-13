# 1. Haal de actieve netwerkconfiguratie op
$config = Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -eq 'Up' } | Select-Object -First 1

if ($config) {
    $ipAddress = $config.IPv4Address.IPAddress
    $gateway   = $config.IPv4DefaultGateway.NextHop
    $dnsServer = $config.DNSServer.ServerAddresses

    # 2. Weergave van de netwerkgegevens
    Write-Host "=== Netwerkinformatie ===" -ForegroundColor Green
    Write-Host "IP-adres:      $ipAddress"
    Write-Host "Gateway:       $gateway"
    Write-Host "DNS-server(s): $($dnsServer -join ', ')"
    Write-Host "===========================`n" -ForegroundColor Green

    # 3. Test poorten richting de gateway
    Write-Host "Bezig met testen van poort 53 (DNS) naar gateway..." -ForegroundColor Yellow
    Test-NetConnection -ComputerName $gateway -Port 53

    Write-Host "`nBezig met testen van poort 443 (HTTPS) naar gateway..." -ForegroundColor Yellow
    Test-NetConnection -ComputerName $gateway -Port 443

    # 4. DNS-resolutie testen
    Write-Host "`n=== DNS-resolutie Test ===" -ForegroundColor Green
    $testDomain = "www.google.com"
    Write-Host "Bezig met opzoeken van $testDomain..." -ForegroundColor Yellow

    $dnsResult = Resolve-DnsName -Name $testDomain -ErrorAction SilentlyContinue
    if ($dnsResult) {
        Write-Host "[OK] DNS-resolutie gelukt! Gevonden IP-adres(sen):" -ForegroundColor Green
        $dnsResult | Select-Object Name, IPAddress, Type | Format-Table -AutoSize
    } else {
        Write-Host "[FOUT] DNS-resolutie mislukt voor $testDomain" -ForegroundColor Red
    }
} else {
    Write-Host "Geen actieve netwerkverbinding met een gateway gevonden." -ForegroundColor Red
}
