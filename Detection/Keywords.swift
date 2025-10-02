import Foundation
struct Keywords {
    static let critical: [String] = [
        "mobilt bankid", "bank id", "verifiera med bankid",
        "säkerhetsavdelningen", "överföra till säkert konto",
        "föra över pengar", "lämna kontonummer", "lösenord",
        "installera fjärrstyrning", "teamviewer", "anydesk", "remote"
    ]
    static let pressure: [String] = [
        "omedelbart", "genast", "annars spärras", "spärras nu",
        "polisanmäla dig", "säkerhetsrisk", "bedrägeri på ditt konto",
        "du måste", "utan dröjsmål"
    ]
    static let regexAccount = try! NSRegularExpression(
        pattern: #"(SE\d{2}\s?\d{4}\s?\d{4}|\b\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\b)"#,
        options: [.caseInsensitive]
    )
}
