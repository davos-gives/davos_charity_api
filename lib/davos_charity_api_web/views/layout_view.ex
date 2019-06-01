defmodule DavosCharityApiWeb.LayoutView do
  use DavosCharityApiWeb, :view

  import IEx
  def primary_colour(conn, params) do
    cond do
      params == DavosCharityApiWeb.CampaignView ->
        conn.assigns.campaign.primary_colour || "#e5ad23"
      params == DavosCharityApiWeb.ReceiptView ->
        conn.assigns.template.primary_colour || "#e5ad23"
      params == DavosCharityApiWeb.ReceiptTemplateView ->
        conn.assigns.template.primary_colour || "#e5ad23"
      true ->
         "#e5ad23"
    end
  end

  def secondary_colour(conn, params) do
    cond do
      params == DavosCharityApiWeb.CampaignView ->
        conn.assigns.campaign.secondary_colour || "#411E82"
      params == DavosCharityApiWeb.ReceiptView ->
        conn.assigns.template.secondary_colour || "#e5ad23"
      params == DavosCharityApiWeb.ReceiptTemplateView ->
        conn.assigns.template.secondary_colour || "#e5ad23"
      true ->
        "#411E82"
    end
  end

  def tertiary_colour(conn, params) do
    cond do
      params == DavosCharityApiWeb.CampaignView ->
        conn.assigns.campaign.tertiary_colour || "#BB8B0E"
        params == DavosCharityApiWeb.ReceiptView ->
          conn.assigns.template.tertiary_colour || "#e5ad23"
        params == DavosCharityApiWeb.ReceiptTemplateView ->
          conn.assigns.template.tertiary_colour || "#e5ad23"
      true ->
        "#BB8B0E"
    end
  end

  def quaternary_colour(conn, params) do
    cond do
      params == DavosCharityApiWeb.CampaignView ->
        conn.assigns.campaign.quaternary_colour || "#FFFFFF"
      params == DavosCharityApiWeb.ReceiptView ->
        conn.assigns.template.quaternary_colour || "#e5ad23"
      params == DavosCharityApiWeb.ReceiptTemplateView ->
        conn.assigns.template.quaternary_colour || "#e5ad23"
      true ->
        "#FFFFFF"
    end
  end

  def quinary_colour(conn, params) do
    cond do
      params == DavosCharityApiWeb.CampaignView ->
        conn.assigns.campaign.quinary_colour || "#666271"
      params == DavosCharityApiWeb.ReceiptView ->
        conn.assigns.template.quinary_colour || "#e5ad23"
      params == DavosCharityApiWeb.ReceiptTemplateView ->
        conn.assigns.template.quinary_colour || "#e5ad23"
      true ->
        "#666271"
    end
  end

  def font(conn, params) do
    cond do
      params == DavosCharityApiWeb.CampaignView ->
        conn.assigns.campaign.font || "Open Sans"
      true ->
        "Open Sans"
    end
  end
end
