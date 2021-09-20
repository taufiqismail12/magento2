<?php

namespace Mageplaza\HelloWorld\Controller\Index;

use Magento\Framework\App\Action\Context;
use Magento\Framework\App\ResponseInterface;

class Display extends \Magento\Framework\App\Action\Action
{

    protected $_pageFactory;
    public function __construct(Context $context, \Magento\Framework\View\Result\PageFactory $pageFactory)
    {
        $this->_pageFactory = $pageFactory;
        parent::__construct($context);
    }

    /**
     * @inheritDoc
     */
    public function execute()
    {
       return $this->_pageFactory->create();
    }
}
