# -*- coding: utf-8 -*-

def build(id):
    import weasyprint
    from weasyprint import HTML

    return HTML('http://localhost:4001/receipts/{id}'.format(id=id)).write_pdf('temp/{id}.pdf'.format(id=id))
