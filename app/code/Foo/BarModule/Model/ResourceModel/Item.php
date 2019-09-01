<?php

namespace \Foo\BarModule\Model\ResourceModel;

class Item extends AbstactDb
{
    protected function _construct()
    {
        $this->_init('barmodule_table', 'id');
    }
}
