
# from xml.etree.ElementTree import ElementTree, Element, tostring
# from xml.dom import minidom
from lxml.etree import Element, SubElement, tostring

shortcuts = {
    # 'COMMAND_L, F2': ['iTerm', '/Applications/iTerm.app'],
    # 'COMMAND_L, F3': ['Chrome', '/Applications/Google Chrome.app'],
    # 'COMMAND_L, F4': ['Evernote', '/Applications/Evernote.app'],
    # 'COMMAND_L, F5': ['FoxMail', '/Applications/Foxmail.app'],
    # 'COMMAND_L, F6': ['Skype', '/Applications/Skype.app'],
    # 'COMMAND_L, F7': ['Wunderlist', '/Applications/Wunderlist.app'],
    'F2': ['Chrome', '/Applications/Google Chrome.app'],
    'F3': ['FoxMail', '/Applications/Foxmail.app'],
    'F4': ['Evernote', '/Applications/Evernote.app'],
    'F5': ['Skype', '/Applications/Skype.app'],
    'F6': ['Wunderlist', '/Applications/Wunderlist.app'],
    'F7': ['iTerm', '/Applications/iTerm.app'],
    # 'F13': ['Pomotodo', '/Applications/Pomotodo.app'],
    'F14': ['Dictionary', '/Applications/Dictionary.app'],
}

modifier_flag = 'COMMAND_L'


class ShortKey(object):
    def __init__(self, func, key):
        self.keys = [k.strip() for k in key.split(',')]
        self.func = func

    @property
    def name(self):
        return '-'.join(self.keys + [self.func])

    @property
    def identifier(self):
        return '.'.join(['private'] + [k.lower() for k in self.keys])

    def remap_desc(self, keycode):
        desc = ['__KeyToKey__']
        desc.append('KeyCode::%s,' % self.keys[-1])
        if len(self.keys) == 2:
            modifier = 'ModifierFlag::%s,' % self.keys[0]
            desc.append(modifier)
        desc.append('KeyCode::%s' % keycode)
        return ' '.join(desc)


def gen_private_xml():
    r = Element('root')
    for key, app in shortcuts.iteritems():
        app_name, app_path = app
        # vkopenurldef
        vkcode = 'VK_OPEN_URL_APP_%s' % app_name
        vk = Element('vkopenurldef')
        SubElement(vk, 'name').text = 'KeyCode::%s' % vkcode
        SubElement(vk, 'url', type='file').text = app_path
        # item
        shortkey = ShortKey(app_name, key)
        item = Element('item')
        SubElement(item, 'name').text = shortkey.name
        SubElement(item, 'identifier').text = shortkey.identifier
        SubElement(item, 'autogen').text = shortkey.remap_desc(vkcode)
        r.extend((vk, item))
    return r

if __name__ == '__main__':
    root = gen_private_xml()
    with open('private.xml', 'w') as f:
        f.write(tostring(root, pretty_print=True))
