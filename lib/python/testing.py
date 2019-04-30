# -*- coding: utf-8 -*-

def test():
    import weasyprint
    from weasyprint import HTML

    return HTML('http://localhost:4001/receipt_templates/1').write_pdf('weasyprint-website.pdf')
