<?php /** @noinspection PhpUndefinedClassInspection */

namespace \Foo\BarModule\Model;

use Magento\Framework\Model\AbstractModel;

class Item extends AbstractModel
{
    protected function _construct()
    {
        $this->_init(\Foo\BarModule\Model\ResourceModel\Item::class);
    }
}
